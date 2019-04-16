# Radiator Media Sketch

This is a sketch for media/file abstraction in Podlove Radiator. The goal is to provide usable abstractions on top of files that are stored in different locations.

There are multiple scopes for files:

- network (cover image)
- podcast (cover image)
- episode (cover image, audio files, metadata files)
- user (avatar image)
- contributor (avatar image)

We support multiple ways of storage. Our primary target is "S3 compatible" storage but other storages like sFTP or CDNs like podseed must be possible as well.

The idea of this sketch implementation is that there is a finite amount of file variants (network cover image, episode audio file, etc.) so each of these can be implemented as its own module and define variable behavior like the storage path within the module. Shared behavior like url generation and storing the file is available via uniform api and delegated to whichever storage implementation.

The public API are all modules under the `Radiator.Media.File` namespace. For now:

- `Radiator.Media.File.AudioFile`
- `Radiator.Media.File.PodcastCoverFile`

The Ecto file models are:

- `Radiator.Media.NetworkFile`
- `Radiator.Media.PodcastFile`
- `Radiator.Media.EpisodeFile`
- (others missing for now, like user and contributor)

They are ecto schemas on the same "files" table, just with different associations defined in the schema. `NetworkFile` references a network, `PodcastFile` references a podcast etc.

## Let's see it in Action

```elixir
alias Radiator.Media.Storage
alias Radiator.Media.EpisodeFile
alias Radiator.Media.File.AudioFile

storage = %Storage{type: :s3}

file = %EpisodeFile{
  filename: "5432e245-e109-4c55-8c32-9233a39188ca.mp3",
  mime: "audio/mpeg",
  size: 128391,
  episode_id: 23
}

url = AudioFile.url(storage, file)
IO.puts(url)
```

## Thoughts

### Storage Granularity

The storage type might be persisted in the file schema, allowing to safe different files in different locations. We had this request a few times in Podlove Publisher. 

Scenarios:

1) Migrating from a different system. The migrated podcast should serve files as before, for example from some sFTP. New podcasts, or even new episode in the same podcast, can use a more Radiator-esque storage.
2) Latest 10 episodes served from a fast but expensive storage, archive from a slower but cheaper storage.

Question is on what level would we do manage this. The deeper down (episode), the harder it becomes to migrate, but the more flexible it is (audio files from storage x but meta data from storage y? be my guest!).

## TODO

- figure out how to use protocols to enforce a uniform api
- define where tracking URLs come from -- or in general, what types of URLs have to be separated (physical, public, tracking)
- where would image variants (resizing) be handled; is this a separate concern?
- write some tests or at least play with it in iex to confirm it's working as intended
- move to radiator repo
