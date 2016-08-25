# some vars for development testing
developerEmail = "your email"

module.exports = [
  {
    id: "general"
    data: [
      {
        id: "emailFrom",
        displayName: "Email Von"
        value: developerEmail
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