# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Work.create!(
  [
    {
      name: "狂犬病予防集合注射に関する業務",
      summary: "狂犬病予防法に基づく業務",
      period: 10,
      user_id: 1,
      department_id: 2,
      firstid: 1,
    },
    {
      name: "環境基本計画に関する業",
      summary: "A市環境基本条例に基づく業務",
      period: 9,
      user_id: 1,
      department_id: 2,
      firstid: 2,
    }
  ]
)