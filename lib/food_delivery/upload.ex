defmodule FoodDelivery.Upload do
  @moduledoc false

  def prepare(attrs, upload_key) do
    %{^upload_key => upload} = attrs

    {upload, %{attrs | upload_key => upload.filename}}
  end

  @spec upload(Plug.Upload.t()) :: :ok
  def upload(%Plug.Upload{} = upload) do
    base_path = "./priv/static/uploads"

    unless File.exists?(base_path), do: File.mkdir!(base_path)
    File.cp(upload.path, Path.expand("#{base_path}/#{upload.filename}"))
  end
end
