defmodule Radiator.Media.File.Definition do
  defmacro __using__(_) do
    quote do
      alias Radiator.Media.Storage

      @doc """
      Research needed: Probably need a protocol here to have proper types.
      """
      def url(%Storage{type: type}, file) do
        path = __MODULE__.relative_path(file)

        module = Radiator.Media.Storage.get_module(type)
        apply(module, :url, [path])
      end

      def store(%Storage{type: type}, source, file) do
        path = __MODULE__.relative_path(file)

        module = Radiator.Media.Storage.get_module(type)
        apply(module, :store, [source, path])
      end
    end
  end
end
