defmodule Radiator.Media.Storage.S3 do
  alias ExAws.S3

  def url(path) do
    path
  end

  def store(source, path) when is_binary(source) do
    content_type = "application/octet-stream"

    source
    |> S3.Upload.stream_file()
    |> S3.upload(bucket(), path, content_type: content_type)
    |> ExAws.request!()
  end

  defp bucket do
    Application.get_env(:radiator, :storage_bucket)
  end
end
