const mongoose = require("mongoose")

mongoose.connect(
  "mongodb+srv://alexclapou:RlqAS2yoPO8TzLXp@cluster0.iyacl3u.mongodb.net/soa?retryWrites=true&w=majority"
)
mongoose.set("debug", (collectionName, method, query, doc) => {
  console.log(`${collectionName}.${method}`, JSON.stringify(query), doc)
})
