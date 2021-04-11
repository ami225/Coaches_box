# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Coach.create!(
    name: "丸山主税",
    introduction: "サッカーとアイスホッケーをやっていました。どんどん質問してね！！",
    email: "coach@coach",
    password: "111111",
    profile_image: open("./app/assets/images/n0281.png")
    )
    
Coach.create!(
    name: "山田太郎",
    introduction: "ラグビーを大学時代しており、キャプテンを務めていました",
    email: "tarou@tarou",
    password: "222222",
    profile_image: open("./app/assets/images/rugby1.jpg")
    )
    
User.create!(
    name: "山田直子",
    introduction: "〇〇大学剣道部主将です。",
    email: "naoko@naoko",
    password: "nnnnnn",
    profile_image: open("./app/assets/images/r0843.png")
    )
    
Category.create!(
    name: "ラグビー",
    )
    
Category.create!(
    name: "サッカー",
    )

Category.create!(
    name: "剣道",
    )
    
Category.create!(
    name: "バスケットボール",
    )
    
Category.create!(
    name: "ラクロス",
    )
    
Category.create!(
    name: "アイスホッケー",
    )
    
Category.create!(
    name: "野球",
    )
    
Category.create!(
    name: "バレーボール",
    )
    
Category.create!(
    name: "柔道",
    )

