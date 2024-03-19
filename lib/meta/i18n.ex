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
