# some vars for development testing
#
#

serverConfig = require("./serverConfig")

module.exports = (env) -> [
  {
    id: "general"
    data: [
      {
        id: "imageUrl",
        displayName: "Base Url der Bilder"
        value: serverConfig(env).service.contacts.imageUrl
      },
      {
        id: "reservationMaxDate",
        displayName: "Letzter Buchungstag"
        value: "2017-12-30"
      }
    ]
  }
  {
    id: "bookingTime"
    data: [
      {
        id: "09",
        value: "09:00"
      },
      {
        id: "12",
        value: "12:00"
      },
      {
        id: "15",
        value: "15:00"
      }
    ]
  }
]
