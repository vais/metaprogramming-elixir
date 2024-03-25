defmodule Meta.I18N do
  use Meta.Translator

  locale("en",
    flash: [
      hello: "Hello, %{first} %{last}!",
      bye: "%{name}, Bye!"
    ],
    users: [
      title: "Users",
      address: [
        city: "City",
        something: [
          else: [
            the: [
              thing: "the thing"
            ]
          ]
        ]
      ]
    ],
    title: [
      users: {"user", "users"},
      users_online: {"There is 1 %{type} user online", "There are %{count} %{type} users online"}
    ]
  )

  locale("fr",
    flash: [
      hello: "Salut, %{first} %{last}!",
      bye: "%{name}, Au revoir!"
    ],
    users: [
      title: "Utilisateurs",
      address: [
        city: "Le Citie"
      ]
    ]
  )
end
