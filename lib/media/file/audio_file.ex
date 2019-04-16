defmodule Radiator.Media.File.AudioFile do
  use Radiator.Media.File.Definition

  @moduledoc """
  Audio file context.

  We know files are only attached to episodes so we need no "scope".

  Each ***File module is responsible for building path information,
  while the File itself only knows its filename.

  ## Example

    storage = %Radiator.Media.Storage{type: :s3}

    file = %Radiator.Media.EpisodeFile{
      filename: "5432e245-e109-4c55-8c32-9233a39188ca.mp3",
      mime: "audio/mpeg",
      size: 128391,
      episode_id: 23
    }

    Radiator.Media.File.AudioFile.url(storage, file)

  """
  alias Radiator.Media.EpisodeFile

  @extension_whitelist ~w(.mp4 .m4a .mp3 .ogg .oga)

  def relative_path(file = %EpisodeFile{filename: filename}) do
    "#{path_prefix(file)}/audio/#{filename}"
  end

  def path_prefix(%EpisodeFile{episode: episode}) do
    "/network_#{episode.podcast.network.id}/podcast_#{episode.podcast.id}/episode_#{episode.id}"
  end

  def validate(_, file) do
    file_extension = file.filename |> Path.extname() |> String.downcase()
    Enum.member?(@extension_whitelist, file_extension)
  end
end
