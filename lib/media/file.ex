defmodule Radiator.Media.File do
  import Ecto.Changeset

  def changeset(file, attrs) do
    file
    |> cast(attrs, [:size, :mime, :filename])
    |> validate_required(:filename)
  end
end
