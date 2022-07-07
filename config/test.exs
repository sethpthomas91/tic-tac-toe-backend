import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :tic_tac_toe_backend, TicTacToeBackend.Repo,
  username: "postgres",
  password: "myPassword",
  hostname: "localhost",
  database: "tic_tac_toe_backend_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tic_tac_toe_backend, TicTacToeBackendWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "puKNAirCmkeMK48GcZ/buvlzZ4SM8JcDq3MQFB2FyJg5zmabXPQCXgLeNRHZEhqU",
  server: false

# In test we don't send emails.
config :tic_tac_toe_backend, TicTacToeBackend.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
