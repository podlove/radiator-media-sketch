defmodule Radiator.Media.File.PodcastCoverFile do
  use Radiator.Media.File.Definition

  alias Radiator.Media.Storage
  alias Radiator.Media.PodcastFile

  @extension_whitelist ~w(.jpg .png)

  def relative_path(file = %PodcastFile{filename: filename}) do
    "#{path_prefix(file)}/audio/#{filename}"
  end

  def path_prefix(%PodcastFile{podcast: podcast}) do
    "/network_#{podcast.network.id}/podcast_#{podcast.id}"
  end

  def validate(_, file) do
    file_extension = file.filename |> Path.extname() |> String.downcase()
    Enum.member?(@extension_whitelist, file_extension)
  end
end
