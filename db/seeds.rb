# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Friend.create!(
   last_name: '横田',
   first_name: '智也',
   last_name_en: 'Yokota',
   first_name_en: 'Tomoya',
   group: '新郎友人',
   caption: 'たぬきちです。よろしくお願いします。もうすぐ春ですね！楽しい季節です。',
   job: 'プログラマー',
)
Friend.create!(
   last_name: '渕上',
   first_name: '紘詩',
   last_name_en: 'Fuchigami',
   first_name_en: 'Hiroshi',
   group: '新郎友人',
   caption: '元菊鹿中学校生徒会長、グレートティーチャーフチガミ（GTF）が来てくれたぞ！',
   job: '小学校教員',
)
Friend.create!(
   last_name: '石阪',
   first_name: '靖英',
   last_name_en: 'Ishizaka',
   first_name_en: 'Yasuhide',
   group: '新郎友人',
   caption: '元菊鹿中野球部5番ショート、打てて守れて野球センス◎。新郎はマリオパーティでも全然勝てなかったぞ！',
   job: '理学療法士',
)