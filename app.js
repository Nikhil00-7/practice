const express = require('express')
const app = express()

const PORT = 3000

let healthy = true


app.get("/health", (req, res) => {
    if (healthy) {
        return res.status(200).json({message: "app is healthy"})
    } else {
        return res.status(500).json({message: "app is unhealthy"})
    }
})


app.get("/stop", (req, res) => {

    healthy = false
    console.log(
    "hello world"
    )
    console.log(
    "hello world",
 
    )
    return res.json({message: "application stopped"})
})


app.get("/start", (req, res) => {
    healthy = true
    return res.json({message: "application started"})
})

app.listen(PORT, () => {
    console.log(`service is started on port ${PORT}`)
})
