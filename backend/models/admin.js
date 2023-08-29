const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const adminSchema = new mongoose.Schema(
  {
    email: {
      type: String,
      lowercase: true,
      required: [true, "userName can't be empty"],
      // @ts-ignore
      match: [
        /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
        "userName format is not correct",
      ],
      unique: true,
    },
    password: {
      type: String,
      required: [true, "password is required"],
    },
    name: {
      type: String,
      required: [false, "name is required"],
    },
    phoneNumber: {
      type: String,
      required: [false, "mobile is required"],
    },
    products: {
      type: ["String"],
    },
    shopName:{
      type: String,
      required: [true, "shopName is required"],
    },
    shopno: {
      type: String,
    },
    landmark: {
      type: String,
      required: [true, "landmark is required"],
    },
    city:{
      type: String,
      required: [true, "city is required"],
    },
    state:{
      type: String,
      required: [true, "state is required"],
    },
    pincode:{
      type: String,
      required: [true, "pincode is required"],
    }
  },
  { timestamps: true }
);

adminSchema.pre("save", async function () {
  console.log("Hashin the passwrod");
  var user = this;
  if (!user.isModified("password")) {
    return;
  }
  try {
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(user.password, salt);

    user.password = hash;
  } catch (err) {
    throw err;
  }
});

adminSchema.statics.findAndValidate = async function (email, password) {
  const foundUser = await this.findOne({ email });
  const isValid = await bcrypt.compare(password, foundUser.password);
  return isValid ? foundUser : false;
};
module.exports = mongoose.model("Admin", adminSchema);
