import express from "express";
import controller from "../controllers/apiController";
const router = express.Router();

router.get("/fetch_skroutz_points", controller.getSkroutzPoints);

export default router;
