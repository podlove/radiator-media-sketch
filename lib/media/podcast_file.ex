defmodule Radiator.Media.PodcastFile do
  use Ecto.Schema

  import Ecto.Query, warn: false
  import Radiator.Media.File, only: [changeset: 2]

  alias Radiator.Directory.Podcast

  schema "files" do
    field :size, :integer
    field :mime, :string
    field :filename, :string

    belongs_to :podcast, Podcast
  end
end
