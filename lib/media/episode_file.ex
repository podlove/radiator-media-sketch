defmodule Radiator.Media.EpisodeFile do
  use Ecto.Schema
  import Ecto.Query, warn: false

  # fixme: use, not import -- or is there a better way for this polymorphic table?
  import Radiator.Media.File, only: [changeset: 2]

  alias Radiator.Directory.Episode

  schema "files" do
    field :size, :integer
    field :mime, :string
    field :filename, :string

    belongs_to :episode, Episode
  end
end
