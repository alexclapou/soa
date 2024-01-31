const jwt = require("jsonwebtoken")
const User = require("./db/user")

const index = async (_, res) => {
  console.log("asd")
  const users = await User.find({})
  res.send(users)
}

const login = async (req, res) => {
  const { name } = req?.body || {}
  const users = await User.find({})
  const user = await User.findOne({ name: name })
  if (user) {
    const token = jwt.sign({ id: user.id }, "very_secret_key")

    res.json({ token: token })
  } else {
    res.send({ message: "Authentication failed" })
  }
}

module.exports = {
  index,
  login,
}
