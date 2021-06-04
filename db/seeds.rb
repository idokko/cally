# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

password = ENV['LOGIN_PASSWORD']

User.create(
    [
        {
            name: 'admin',
            email: 'cally.controller@gmail.com',
            password: password,
            password_confirmation: password,
            artist: 'yes',
            prefectures: '愛知県',
            admin: true
        },
        {
            name: '123',
            email: '123@co.jp',
            password: password,
            password_confirmation: password,
            artist: 'yes',
            prefectures: '鳥取県',
            admin: false
        },
        {
            name: '123456',
            email: '123456@co.jp',
            password: password,
            password_confirmation: password,
            artist: 'no',
            prefectures: '北海道',
            admin: false
        },
    ]
)

Type.create([
    {work_type: "色紙"},
    {work_type: "看板"},
    {work_type: "メニュー"}
    ])