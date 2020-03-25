package main

import (
	"github.com/flaviostutz/promster/utils"
	"fmt"
)

func main() {
	fmt.Print("Container up")
}

func executeTemplate(dir string, templ string, input map[string]interface{}) (string, error) {
	tmpl := template.New("root")
	tmpl1, err := tmpl.ParseGlob(dir + "/*.tmpl")
	buf := new(bytes.Buffer)
	err = tmpl1.ExecuteTemplate(buf, templ, input)
	if err != nil {
		return "", err
	}
	return buf.String(), nil
}