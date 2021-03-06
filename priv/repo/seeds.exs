# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sibt.Repo.insert!(%Sibt.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Sibt.{Repo, User, Operation}
alias Faker.{Lorem, App, Internet}

alias Faker.Company.En, as: Company

user_data = [
  %{
    first_name: "Allan",
    last_name: "MacGregor",
    email: "amacgregor@allanmacgregor.com",
    provider: "facebook",
    token: "EAAErXxTO4j8BABUnZCqD"
  },
  %{
    first_name: "Tony",
    last_name: "Stark",
    email: "tony@starkenterprises.com",
    provider: "facebook",
    token: "EAAErXxTO4j8BABUnZCqD"
  }
]

Enum.each(user_data, fn data ->
  changeset = User.changeset(%User{}, data)
  Repo.insert(changeset)
end)

user = Repo.get(User, 1)

Enum.each(1..10, fn x ->
  project_data = %{
    project_id: Internet.slug(),
    title: App.name(),
    summary: Company.catch_phrase(),
    description: Lorem.sentence(10..20),
    like_count: Enum.random(0..10000),
    view_count: Enum.random(0..10000),
    subscriber_count: Enum.random(0..1000)
  }

  Operation.create_project(user, project_data)
end)
