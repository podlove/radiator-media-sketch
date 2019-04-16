defmodule Radiator.Media.NetworkFile do
  use Ecto.Schema
  import Ecto.Query, warn: false
  import Radiator.Media.File, only: [changeset: 2]

  alias Radiator.Directory.Network

  schema "files" do
    field :size, :integer
    field :mime, :string
    field :filename, :string

    belongs_to :network, Network
  end
end
