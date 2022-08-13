import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :zone, ZoneWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "WGME7jE7RgQJ2VdAMaekIC+wg5/l3T12hX30rFc097EPoPRkNca6pxTJatalVff6",
  server: false

# In test we don't send emails.
config :zone, Zone.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
