"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const axios_1 = __importDefault(require("axios"));
const url = require("url");
// interface VersionModel {
//     version: String;
//     notes: String;
// }
var skroutzBase = "https://www.skroutz.gr/checkout/fetch_skroutz_points?coordinates%5Blat%5D=38.04591429362779&coordinates%5Blng%5D=23.505545947811747&radius=10000";
const getSkroutzPoints = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    //   fetch("https://www.skroutz.gr/checkout/fetch_skroutz_points?coordinates%5Blat%5D=38.043698980081075&coordinates%5Blng%5D=23.7613624915&radius=0.3153670462368586", {
    //   "headers": {
    //     "accept": "application/json, text/plain, */*",
    //     "accept-language": "en-US,en;q=0.9",
    //     "sec-ch-ua": "\"Chromium\";v=\"104\", \" Not A;Brand\";v=\"99\", \"Google Chrome\";v=\"104\"",
    //     "sec-ch-ua-mobile": "?0",
    //     "sec-ch-ua-platform": "\"macOS\"",
    //     "sec-fetch-dest": "empty",
    //     "sec-fetch-mode": "cors",
    //     "sec-fetch-site": "same-origin",
    //     "x-csrf-token": "wVIAOu9RbwNFqSpDy+km30+M4gYtefZ/B8k6bNNk0vr5PL8yjlq2bIuTKLkkcYpXzlwi7mIVIL3Rdzik0dk2KA==",
    //     "x-requested-with": "XMLHttpRequest",
    //     "cookie": "policy_level=%7B%22essential%22%3A%22true%22%2C%22performance%22%3A%22true%22%2C%22preference%22%3A%22true%22%2C%22targeting%22%3A%22true%22%7D; _gcl_au=1.1.1916575189.1657692675; _hjSessionUser_1468002=eyJpZCI6IjNkYzdjODhkLWEyNmYtNTYyOC04OWMzLTkyMjZmNTAzMzBjMiIsImNyZWF0ZWQiOjE2NTc2OTI2NzQ2MDAsImV4aXN0aW5nIjp0cnVlfQ==; _sa_meta=%7B%22app_type%22%3A%22web%22%2C%22cp%22%3A%22f%22%2C%22tags%22%3A%22%22%7D; _hjMinimizedPolls=709620; analytics_session=77ad5368-4e88-4ad2-a32e-4f3fb8dabf67; __skr_nltcs_ss=%7B%22version%22%3A1%2C%22session%22%3A%2277ad5368-4e88-4ad2-a32e-4f3fb8dabf67%22%7D; _hjIncludedInSessionSample=0; _hjSession_1468002=eyJpZCI6IjMzZTI3YzljLTFhMzItNGIxMi1iYWNlLWI3ZjQxYjRhMzk4ZCIsImNyZWF0ZWQiOjE2NjIxMjE1MjgxNjYsImluU2FtcGxlIjpmYWxzZX0=; _hjAbsoluteSessionInProgress=0; _gid=GA1.2.1583610041.1662121528; __cf_bm=95lpwNGZFuYm.a9B40KtKNI4LhVgN1qbvsouZLRKw7c-1662121861-0-AQunvBWUqbkupBDtDU1uOjYjTi+/7nNBLNNW11li6qJYnIy7Rk9nghI0BDaORcyYZFznkOIOj/wp+0f9gB1kpyQ=; logged_in=true; _hjCachedUserAttributes=eyJhdHRyaWJ1dGVzIjp7IkNvdW50cnkiOiJHUiIsIklzR3JlZWNlIjp0cnVlLCJTa3JvdXR6IFBsdXMiOmZhbHNlLCJTa3JvdXR6IFN0YWZmIjpmYWxzZSwiVXNlciBSZXNlYXJjaCI6IiJ9LCJ1c2VySWQiOiJiYTVkYzdmYjNjOWNlZjIyYjAxZWEwYjZhMGZiY2YyZTY2NWYxMzQ1In0=; _ga_RXGTX5SZLT=GS1.1.1662121528.55.1.1662122097.0.0.0; _ga=GA1.1.1690645652.1657692674; _helmet_couch=nk8poAYopHGo41%2BQlDk31TPD9coBE7BKOP%2FXzYmgCpsxs6U0aTpEN0ar%2BS%2FHDu%2B8SwKDPIV36FOnITUY6046sjMQCq5iyuvvG8c6hxaEqCJIaFerfbbpalan2WIz79gN%2FLYPHJm3TxsI4vSc8vCP1F4r8j1OUVWtOq7tTZJxBMr%2B1MZRPmYqEi5mLGE79kWMWOHqKQFFXRVLrnbb8rwn2DXAxHB2z6K%2FBcqi5h0QVx5lBp9YtSfWTCdNdSJERR94DYsuI%2FKLynBIcdaPGVuPwSfEOTg5bzjSqkUl45l5jtkUGl4qbPd27c5aunvcZtdjZ1kL7RI2Xh9kk1s%2BmmAhyLtWDzITLI15Ny9%2Bxdc8seGRgl6rQVUjmwUFQ7VfS6ou1hkuGjEOERtgjMFyfd5KLz2kZpwj3CEA738hMziWefVCdOE%2FjXXMrjNoIP8nOKNfqhyOX5kEwK%2FAPSWEUP%2B4rQqj3XSlYdEiYw4ps9%2BWJjHNnrziLaXe5DOtGLsX04Wxs7BjdvlmP%2Bmcv6Ir9lcWTX1Ci48WhO3mvxD77yCO7QzD9qQqT%2BohvzgBy9DO0FAKlB%2FjEHE%2FE%2FsVYliHYFPvoNU%2B7FnyLTwKNjs4Sy%2FpY1b1Py0MebT8BSh73RkPyHmItsr%2FcG%2FgYbVyKhfgg2P0GJDeSBn8HZRDjq%2BBa4wpWR967qISQjJYzKdXClr99aGSbR%2BnWrzvSi8C2RUL%2FRanBS%2FDbhhatoWkxDxI%2BVJeaDUn%2FQYpZX6B63ZRomtIcJDnKKA1uDrve6uKkOmpyorSqdmez0vp%2FxyrDGAxD%2BoEUbUU97ZJng9r--KebGmnwvVlTj4zhO--B4G7Oby47Y27wqVimVZ%2Brg%3D%3D",
    //     "Referer": "https://www.skroutz.gr/checkout/details",
    //     "Referrer-Policy": "strict-origin-when-cross-origin"
    //   },
    //   "body": null,
    //   "method": "GET"
    // });
    const queryObject = url.parse(req.url, true).query;
    console.log(queryObject);
    console.log(req.url);
    axios_1.default
        .get(skroutzBase, {
        headers: {
            accept: "application/json, text/plain, */*",
            "accept-language": "en-US,en;q=0.9",
            "sec-ch-ua": '"Chromium";v="104", " Not A;Brand";v="99", "Google Chrome";v="104"',
            "sec-ch-ua-mobile": "?0",
            "sec-ch-ua-platform": '"macOS"',
            "sec-fetch-dest": "empty",
            "sec-fetch-mode": "cors",
            "sec-fetch-site": "same-origin",
            "x-requested-with": "XMLHttpRequest",
            Referer: "https://www.skroutz.gr/checkout/details",
            "Referrer-Policy": "strict-origin-when-cross-origin",
            "x-csrf-token": "wVIAOu9RbwNFqSpDy+km30+M4gYtefZ/B8k6bNNk0vr5PL8yjlq2bIuTKLkkcYpXzlwi7mIVIL3Rdzik0dk2KA==",
            cookie: "policy_level=%7B%22essential%22%3A%22true%22%2C%22performance%22%3A%22true%22%2C%22preference%22%3A%22true%22%2C%22targeting%22%3A%22true%22%7D; _gcl_au=1.1.1916575189.1657692675; _hjSessionUser_1468002=eyJpZCI6IjNkYzdjODhkLWEyNmYtNTYyOC04OWMzLTkyMjZmNTAzMzBjMiIsImNyZWF0ZWQiOjE2NTc2OTI2NzQ2MDAsImV4aXN0aW5nIjp0cnVlfQ==; _sa_meta=%7B%22app_type%22%3A%22web%22%2C%22cp%22%3A%22f%22%2C%22tags%22%3A%22%22%7D; _hjMinimizedPolls=709620; analytics_session=77ad5368-4e88-4ad2-a32e-4f3fb8dabf67; __skr_nltcs_ss=%7B%22version%22%3A1%2C%22session%22%3A%2277ad5368-4e88-4ad2-a32e-4f3fb8dabf67%22%7D; _hjIncludedInSessionSample=0; _hjSession_1468002=eyJpZCI6IjMzZTI3YzljLTFhMzItNGIxMi1iYWNlLWI3ZjQxYjRhMzk4ZCIsImNyZWF0ZWQiOjE2NjIxMjE1MjgxNjYsImluU2FtcGxlIjpmYWxzZX0=; _hjAbsoluteSessionInProgress=0; _gid=GA1.2.1583610041.1662121528; __cf_bm=95lpwNGZFuYm.a9B40KtKNI4LhVgN1qbvsouZLRKw7c-1662121861-0-AQunvBWUqbkupBDtDU1uOjYjTi+/7nNBLNNW11li6qJYnIy7Rk9nghI0BDaORcyYZFznkOIOj/wp+0f9gB1kpyQ=; logged_in=true; _hjCachedUserAttributes=eyJhdHRyaWJ1dGVzIjp7IkNvdW50cnkiOiJHUiIsIklzR3JlZWNlIjp0cnVlLCJTa3JvdXR6IFBsdXMiOmZhbHNlLCJTa3JvdXR6IFN0YWZmIjpmYWxzZSwiVXNlciBSZXNlYXJjaCI6IiJ9LCJ1c2VySWQiOiJiYTVkYzdmYjNjOWNlZjIyYjAxZWEwYjZhMGZiY2YyZTY2NWYxMzQ1In0=; _ga_RXGTX5SZLT=GS1.1.1662121528.55.1.1662122097.0.0.0; _ga=GA1.1.1690645652.1657692674; _helmet_couch=nk8poAYopHGo41%2BQlDk31TPD9coBE7BKOP%2FXzYmgCpsxs6U0aTpEN0ar%2BS%2FHDu%2B8SwKDPIV36FOnITUY6046sjMQCq5iyuvvG8c6hxaEqCJIaFerfbbpalan2WIz79gN%2FLYPHJm3TxsI4vSc8vCP1F4r8j1OUVWtOq7tTZJxBMr%2B1MZRPmYqEi5mLGE79kWMWOHqKQFFXRVLrnbb8rwn2DXAxHB2z6K%2FBcqi5h0QVx5lBp9YtSfWTCdNdSJERR94DYsuI%2FKLynBIcdaPGVuPwSfEOTg5bzjSqkUl45l5jtkUGl4qbPd27c5aunvcZtdjZ1kL7RI2Xh9kk1s%2BmmAhyLtWDzITLI15Ny9%2Bxdc8seGRgl6rQVUjmwUFQ7VfS6ou1hkuGjEOERtgjMFyfd5KLz2kZpwj3CEA738hMziWefVCdOE%2FjXXMrjNoIP8nOKNfqhyOX5kEwK%2FAPSWEUP%2B4rQqj3XSlYdEiYw4ps9%2BWJjHNnrziLaXe5DOtGLsX04Wxs7BjdvlmP%2Bmcv6Ir9lcWTX1Ci48WhO3mvxD77yCO7QzD9qQqT%2BohvzgBy9DO0FAKlB%2FjEHE%2FE%2FsVYliHYFPvoNU%2B7FnyLTwKNjs4Sy%2FpY1b1Py0MebT8BSh73RkPyHmItsr%2FcG%2FgYbVyKhfgg2P0GJDeSBn8HZRDjq%2BBa4wpWR967qISQjJYzKdXClr99aGSbR%2BnWrzvSi8C2RUL%2FRanBS%2FDbhhatoWkxDxI%2BVJeaDUn%2FQYpZX6B63ZRomtIcJDnKKA1uDrve6uKkOmpyorSqdmez0vp%2FxyrDGAxD%2BoEUbUU97ZJng9r--KebGmnwvVlTj4zhO--B4G7Oby47Y27wqVimVZ%2Brg%3D%3D",
        },
    })
        .then((result) => {
        return res.status(200).json(result.data);
    })
        .catch((error) => {
        return res.status(400).json({
            result: error,
        });
    });
});
exports.default = { getSkroutzPoints };
