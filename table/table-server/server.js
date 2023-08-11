const express = require("express");
const app = express();
const cors = require("cors");
const port = 3000;
const mysql = require("mysql");

// 处理跨域问题 (CORS)
app.use(cors());

// 创建数据库连接
const pool = mysql.createPool({
  connectionLimit: 10, // 连接限制
  host: "localhost", // 数据库服务器地址
  user: "root", // 数据库用户名
  password: "123456", // 数据库密码
  database: "dining_hall", // 数据库名称
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

//总表
app.get("/total", (req, res) => {
  const { startDate, endDate } = req.query;
  const queryString =
    startDate && endDate
      ? `SELECT * FROM total WHERE time >= '${startDate}' AND time <= '${endDate}'`
      : "SELECT * FROM total";

  pool.query(queryString, (error, results, fields) => {
    if (error) throw error;
    // 转换日期格式
    const formattedResults = results.map((row) => {
      if (row.time) {
        const date = new Date(row.time);
        const formattedDate = `${date.getFullYear()}-${String(
          date.getMonth() + 1
        ).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
        return {
          ...row,
          time: formattedDate,
        };
      }
      return row;
    });

    res.json(formattedResults);
  });
});

//明细表
app.get("/details", (req, res) => {
  const { startDate, endDate } = req.query;
  const queryString =
    startDate && endDate
      ? `SELECT * FROM details WHERE time >= '${startDate}' AND time <= '${endDate}'`
      : "SELECT * FROM details";

  pool.query(queryString, (error, results, fields) => {
    if (error) throw error;
    // 转换日期格式
    const formattedResults = results.map((row) => {
      if (row.time) {
        const date = new Date(row.time);
        const formattedDate = `${date.getFullYear()}-${String(
          date.getMonth() + 1
        ).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
        return {
          ...row,
          time: formattedDate,
        };
      }
      return row;
    });

    res.json(formattedResults);
  });
});

// 充值表
app.get("/recharge", (req, res) => {
  const { startDate, endDate } = req.query;
  const queryString =
    startDate && endDate
      ? `SELECT * FROM recharge WHERE time >= '${startDate}' AND time <= '${endDate}'`
      : "SELECT * FROM recharge";

  pool.query(queryString, (error, results, fields) => {
    if (error) throw error;
    // 转换日期格式
    const formattedResults = results.map((row) => {
      if (row.time) {
        const date = new Date(row.time);
        const formattedDate = `${date.getFullYear()}-${String(
          date.getMonth() + 1
        ).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
        return {
          ...row,
          time: formattedDate,
        };
      }
      return row;
    });

    res.json(formattedResults);
  });
});

// 营业表
app.get("/business", (req, res) => {
  const { startDate, endDate } = req.query;
  const queryString =
    startDate && endDate
      ? `SELECT * FROM business_total WHERE time >= '${startDate}' AND time <= '${endDate}'`
      : "SELECT * FROM business_total";

  pool.query(queryString, (error, results, fields) => {
    if (error) throw error;
    // 转换日期格式
    const formattedResults = results.map((row) => {
      if (row.time) {
        const date = new Date(row.time);
        const formattedDate = `${date.getFullYear()}-${String(
          date.getMonth() + 1
        ).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
        return {
          ...row,
          time: formattedDate,
        };
      }
      return row;
    });

    res.json(formattedResults);
  });
});

//   分餐表
app.get("/division", (req, res) => {
  const { startDate, endDate } = req.query;
  const queryString =
    startDate && endDate
      ? `SELECT * FROM division WHERE time >= '${startDate}' AND time <= '${endDate}'`
      : "SELECT * FROM division";

  pool.query(queryString, (error, results, fields) => {
    if (error) throw error;
    // 转换日期格式
    const formattedResults = results.map((row) => {
      if (row.time) {
        const date = new Date(row.time);
        const formattedDate = `${date.getFullYear()}-${String(
          date.getMonth() + 1
        ).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
        return {
          ...row,
          time: formattedDate,
        };
      }
      return row;
    });

    res.json(formattedResults);
  });
});
