defprotocol Otherwise do
  @fallback_to_any true
  def otherwise(m, f)
end

defimpl Otherwise, for: Tuple do
  def otherwise({:error, e}, f) when is_function(f) do
    f.(e)
  end
end

defimpl Otherwise, for: Any do
  def otherwise(m, _), do: m
end

