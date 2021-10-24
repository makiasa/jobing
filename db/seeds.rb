# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.upto(12) do |month|
Work.create!(
              name: "#{month}月の●●に関する業務",
              summary: "#{month}月の●●に関する業務の概要",
              period: month,
              user_id: 1,
              department_id:2,
              firstid: 7 + month,
              task: "#{month}月の●●に関する業務の課題"
            )
end