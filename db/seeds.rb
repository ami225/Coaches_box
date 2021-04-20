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
    
Coach.create!(
    name: "玉木宏樹",
    introduction: "中学、高校、大学で野球をしていました。現在整体師として働いています。",
    email: "hiroki@hiroki",
    password: "333333",
    profile_image: open("./app/assets/images/baseball2.jpg")
    )

Coach.create!(
    name: "須原旬生",
    introduction: "学生時代は剣道一筋！どんどん稽古を仕込んでやる！どんどんこい！",
    email: "jyunki@jyunki",
    password: "444444",
    profile_image: open("./app/assets/images/sakenomi.png")
    )
    
Coach.create!(
    name: "江下紫",
    introduction: "学生時代はラクロスと弓道でキャプテンを任されていました！",
    email: "ramu@ramu",
    password: "555555",
    profile_image: open("./app/assets/images/ramu.png")
    )
    
User.create!(
    name: "山田直子",
    introduction: "〇〇大学剣道部主将です。",
    email: "naoko@naoko",
    password: "nnnnnn",
    profile_image: open("./app/assets/images/r0843.png")
    )
User.create!(
    name: "川部里美",
    introduction: "〇〇大学 卓球部です。",
    email: "satomi@satomi",
    password: "ssssss",
    profile_image: open("./app/assets/images/r0843.png")
    )
    
User.create!(
    name: "黒木亮子",
    introduction: "陸上部です！！",
    email: "ryouko@ryouko",
    password: "rrrrrr",
    profile_image: open("./app/assets/images/avatar.png")
    )
    
User.create!(
    name: "岡田美愛",
    introduction: "ラクロスとバスケをしてました！",
    email: "mini@mini",
    password: "mmmmmm",
    profile_image: open("./app/assets/images/mini.png")
    )
    

