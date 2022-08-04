/** source/controllers/posts.ts */
import { Request, Response, NextFunction } from "express";
import axios, { AxiosResponse } from "axios";
const url = require("url");

import cheerio from "cheerio";
// interface VersionModel {
//     version: String;
//     notes: String;
// }

var skroutzBase = "https://www.skroutz.gr/checkout";
const getSkroutzPoints = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const queryObject = url.parse(req.url, true).query;
  console.log(queryObject);
  console.log(req.url);
  axios
    .get(skroutzBase + req.url)
    .then((result) => {
      return res.status(200).json(result.data);
    })
    .catch((error) => {
      return res.status(400).json({
        result: error,
      });
    });
};

export default { getSkroutzPoints };
