# User seeds

user1 = User.create(name: "Jerry", email: "jerry@example.com", app_id: [10, 1], review_id: [6, 15])
user2 = User.create(name: "Anna", email: "anna@example.com", app_id: [8], review_id: [10])
user3 = User.create(name: "Sandy", email: "sandy@example.com", app_id: [7, 3], review_id: [3, 11])
user4 = User.create(name: "Fiona", email: "fiona@example.com", app_id: [3], review_id: [2])
user5 = User.create(name: "Mike", email: "mike@example.com", app_id: [2], review_id: [7])
user6 = User.create(name: "Vincent", email: "vincent@example.com", app_id: [9], review_id: [14])
user7 = User.create(name: "Timothy", email: "timothy@example.com", app_id: [1], review_id: [4])
user8 = User.create(name: "Brianna", email: "brianna@example.com", app_id: [4, 7], review_id: [5, 12])
user9 = User.create(name: "Patricia", email: "patricia@example.com", app_id: [6, 5], review_id: [1, 8])
user10 = User.create(name: "Aaron", email: "aaron@example.com", app_id: [9, 6], review_id: [9, 13])

# App seeds
app1 = App.create(name: "Banjo Hero: Legends of Country" , category: "game", total_reviews: 2, avg_rating: 2)
app2 = App.create(name: "Not so Final Fantasy", category: "game", total_reviews: 1, avg_rating: 2)
app3 = App.create(name: "Grand Theft Pacifist", category: "game", total_reviews: 2, avg_rating: 2)
app4 = App.create(name: "Ebook Reader", category: "productivity", total_reviews: 1, avg_rating: 3)
app5 = App.create(name: "Notes Keeper", category: "productivity", total_reviews: 1, avg_rating: 4)
app6 = App.create(name: "Just another Calendar", category: "productivity", total_reviews: 2, avg_rating: 3)
app7 = App.create(name: "InstaPrank", category: "social", total_reviews: 2, avg_rating: 3)
app8 = App.create(name: "SnapCrap", category: "social", total_reviews: 1, avg_rating: 3)
app9 = App.create(name: "Lyrics Grabber", category: "music", total_reviews: 2, avg_rating: 5)
app10 = App.create(name: "Remixer", category: "music", total_reviews: 1, avg_rating: 4)

# Review seeds
rev1 = Review.create(content: "An amazing app", rating: 4, user_id: user9.id, app_id: app6.id)
rev2 = Review.create(content: "Terrible, Not enough killing!", rating: 1, user_id: user4.id, app_id: app3.id)
rev3 = Review.create(content: "Its so funny using this", rating: 5, user_id: user3.id, app_id: app7.id)
rev4 = Review.create(content: "Nothing compared to the real thing", rating: 2, user_id: user7.id, app_id: app1.id)
rev5 = Review.create(content: "I expected better", rating: 3, user_id: user8.id , app_id: app4.id)
rev6 = Review.create(content: "Like a Pocket DJ kit", rating: 4, user_id: user1.id, app_id: app10.id)
rev7 = Review.create(content: "Does it ever end!?", rating: 2, user_id: user5.id, app_id: app2.id)
rev8 = Review.create(content: "It does exactly what it says", rating: 4, user_id: user9.id, app_id: app5.id)
rev9 = Review.create(content: "I was lost and now, i'm found!", rating: 5, user_id: user10.id, app_id: app9.id)
rev10 = Review.create(content: "Pretty much meh", rating: 3, user_id: user2.id, app_id: app8.id)
rev11 = Review.create(content: "I prefer it to the original", rating: 4, user_id: user3.id, app_id: app3.id)
rev12 = Review.create(content: "I don't get it!", rating: 1, user_id: user8.id, app_id: app7.id)
rev13 = Review.create(content: "Should never had downloaded it", rating: 2, user_id: user10.id, app_id: app6.id)
rev14 = Review.create(content: "This is so helpful, thank you so much!", rating: 5, user_id: user6.id, app_id: app9.id)
rev15 = Review.create(content: "Not all that impressed", rating: 3, user_id: user1.id, app_id: app1.id)
