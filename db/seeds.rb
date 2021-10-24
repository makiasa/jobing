# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Workflow.create!(
  [
    {
        work_id: 6,
        content: "R3年度の集合注射会場の選定",
        note: "前回（R2年度）における会場別の注射頭数を確認したうえ、会場の統廃合も検討すること",
        filepath: "https://drive.google.com/drive/folders/1xyXOqfa4zIw1JzbC80NZ_6Db3gnOkzMt",
        order:1
      },
    {
      work_id: 6,
      content: "選定したR3年度会場の予約",
      note: "会場へは電話連絡。予約時間帯については、余裕をもって20分前から予約しておくこと",
      filepath: "https://drive.google.com/drive/folders/1xyXOqfa4zIw1JzbC80NZ_6Db3gnOkzMt",
      order:2
    }
  ]
)