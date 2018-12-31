package main

import (
	"fmt"
	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
	"github.com/sirupsen/logrus"
	"net/http"
)

var log = logrus.New()

func init(){
	log.Formatter = new(logrus.JSONFormatter)
	log.Formatter = new(logrus.TextFormatter)
	log.Level = logrus.DebugLevel
}

func main(){
	fmt.Println("Main function:")
	e := echo.New()
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	// Routes
	e.GET("/go-docker", goWithDocker)
	e.Logger.Fatal(e.Start(":3001"))
}

func goWithDocker(c echo.Context) error {
	return c.JSON(http.StatusOK,  "Go with Docker Container")
}
