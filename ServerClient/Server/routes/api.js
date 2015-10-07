var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/diningCourts', function(req, res, next) {
   var locations = [
       {
        "Name": "Earhart",
        "FormalName": "Earhart Dining Court"
    }
   ];
   var response = {"Location": [locations]}
   res.json(response);
});

module.exports = router;
