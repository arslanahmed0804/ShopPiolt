
const Product = require("../models/Product");

const createProduct = async (req, res) => {
  try {
    const {
      name,
      image,
      barcode,
      vendorName,
      purchaseRate,
      quantity,
    } = req.body;

    if (
      !name?.trim() ||
      !barcode?.trim() ||
      !vendorName?.trim() ||
      purchaseRate === undefined ||
      quantity === undefined
    ) {
      return res.status(400).json({
        success: false,
        message:
          "Name, barcode, vendor name, purchase rate and quantity are required",
      });
    }

    const rate = Number(purchaseRate);
    const stock = Number(quantity);

    if (
      !Number.isFinite(rate) ||
      rate < 0 ||
      !Number.isInteger(stock) ||
      stock < 0
    ) {
      return res.status(400).json({
        success: false,
        message:
          "Purchase rate must be non-negative and quantity must be a non-negative whole number",
      });
    }

    const existingProduct = await Product.findOne({
      barcode: barcode.trim(),
    });

    if (existingProduct) {
      return res.status(409).json({
        success: false,
        message: "Product with this barcode already exists",
      });
    }

    const product = await Product.create({
      name: name.trim(),
      image: image?.trim() || "",
      barcode: barcode.trim(),
      vendorName: vendorName.trim(),
      purchaseRate: rate,
      quantity: stock,
    });

    return res.status(201).json({
      success: true,
      message: "Product created successfully",
      product,
    });
  } catch (error) {
    if (error.code === 11000) {
      return res.status(409).json({
        success: false,
        message: "Barcode already exists",
      });
    }

    if (error.name === "ValidationError") {
      return res.status(400).json({
        success: false,
        message: error.message,
      });
    }

    console.error("Create Product Error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};
const getProducts = async (req, res) => {
  try {
    const products = await Product.find().sort({ createdAt: -1 });

    return res.status(200).json({
      success: true,
      count: products.length,
      products,
    });
  } catch (error) {
    console.error("Get Products Error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Failed to fetch products",
    });
  }
};

const updateProduct = async (req, res) => {
  try {
    const { id } = req.params;

    const allowedFields = [
      "name",
      "image",
      "barcode",
      "vendorName",
      "purchaseRate",
      "quantity",
    ];

    const updates = {};

    for (const field of allowedFields) {
      if (req.body[field] !== undefined) {
        updates[field] = req.body[field];
      }
    }

    if (Object.keys(updates).length === 0) {
      return res.status(400).json({
        success: false,
        message: "At least one valid field is required",
      });
    }

    if (updates.name !== undefined) {
      if (typeof updates.name !== "string" || !updates.name.trim()) {
        return res.status(400).json({
          success: false,
          message: "Name cannot be empty",
        });
      }
      updates.name = updates.name.trim();
    }

    if (updates.image !== undefined) {
      if (typeof updates.image !== "string") {
        return res.status(400).json({
          success: false,
          message: "Image must be a string URL",
        });
      }
      updates.image = updates.image.trim();
    }

    if (updates.barcode !== undefined) {
      if (typeof updates.barcode !== "string" || !updates.barcode.trim()) {
        return res.status(400).json({
          success: false,
          message: "Barcode cannot be empty",
        });
      }
      updates.barcode = updates.barcode.trim();
    }

    if (updates.vendorName !== undefined) {
      if (
        typeof updates.vendorName !== "string" ||
        !updates.vendorName.trim()
      ) {
        return res.status(400).json({
          success: false,
          message: "Vendor name cannot be empty",
        });
      }
      updates.vendorName = updates.vendorName.trim();
    }

    if (updates.purchaseRate !== undefined) {
      const rate = Number(updates.purchaseRate);

      if (!Number.isFinite(rate) || rate < 0) {
        return res.status(400).json({
          success: false,
          message: "Purchase rate must be a non-negative number",
        });
      }

      updates.purchaseRate = rate;
    }

    if (updates.quantity !== undefined) {
      const quantity = Number(updates.quantity);

      if (!Number.isInteger(quantity) || quantity < 0) {
        return res.status(400).json({
          success: false,
          message: "Quantity must be a non-negative whole number",
        });
      }

      updates.quantity = quantity;
    }

    const product = await Product.findByIdAndUpdate(
      id,
      { $set: updates },
      { new: true, runValidators: true }
    );

    if (!product) {
      return res.status(404).json({
        success: false,
        message: "Product not found",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Product updated successfully",
      product,
    });
  } catch (error) {
    if (error.name === "CastError") {
      return res.status(400).json({
        success: false,
        message: "Invalid product ID",
      });
    }

    if (error.code === 11000) {
      return res.status(409).json({
        success: false,
        message: "Barcode already belongs to another product",
      });
    }

    if (error.name === "ValidationError") {
      return res.status(400).json({
        success: false,
        message: error.message,
      });
    }

    console.error("Update Product Error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Failed to update product",
    });
  }
};

const deleteProduct = async (req, res) => {
  try {
    const { id } = req.params;

    const product = await Product.findByIdAndDelete(id);

    if (!product) {
      return res.status(404).json({
        success: false,
        message: "Product not found",
      });
    }

    return res.status(200).json({
      success: true,
      message: "Product deleted successfully",
      product,
    });
  } catch (error) {
    if (error.name === "CastError") {
      return res.status(400).json({
        success: false,
        message: "Invalid product ID",
      });
    }

    console.error("Delete Product Error:", error.message);

    return res.status(500).json({
      success: false,
      message: "Failed to delete product",
    });
  }
};


module.exports = { createProduct, getProducts , updateProduct, deleteProduct };
