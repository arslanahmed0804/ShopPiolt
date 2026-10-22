
const mongoose = require("mongoose");

const productSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },

    image: {
      type: String,
      default: "",
      trim: true,
    },

    barcode: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },

    vendorName: {
      type: String,
      required: true,
      trim: true,
    },

    purchaseRate: {
      type: Number,
      required: true,
      min: 0,
    },

    quantity: {
      type: Number,
      required: true,
      min: 0,
      validate: {
        validator: Number.isInteger,
        message: "Quantity must be a whole number",
      },
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Product", productSchema);
