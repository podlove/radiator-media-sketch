defmodule Radiator.Media.Storage do
  defstruct [:type]

  alias __MODULE__

  def get_module(%Storage{type: :s3}),
    do: Radiator.Media.Storage.S3
end
