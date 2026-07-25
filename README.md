#Introduction
This is the frontend for the SubsNotifier mobile application. It is written in Dart and Flutter.

#What does the app do
The main idea is this: Users enter their subscriptions (monthly, yearly etc.). Let's say the date they will be charged on the 23rd of every month for it. We have to send a push notification telling them to update the funds for the particular card to their device on the 20th, the 21st and 22nd. 

Similarly, if it is on the 15th of September on a yearly basis, send them a notification to update the funds against their card on 12th September, then 13th September, then 14th September.

#How will the app generate revenue
We will add multi-card support for this thing (tracking subscriptions and sending notifications for them against all cards the user has), but that will be behind a paywall (USD 10 a month). I plan on using RevenueCat for this.
