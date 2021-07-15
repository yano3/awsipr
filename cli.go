package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net"
	"net/http"
	"os"
)

// Exit codes are int values that represent an exit code for a particular error.
const (
	ExitCodeOK    int = 0
	ExitCodeError int = 1 + iota
)

const url = "https://ip-ranges.amazonaws.com/ip-ranges.json"

// CLI is the command line object
type CLI struct {
	// outStream and errStream are the stdout and stderr
	// to write message from the CLI.
	outStream, errStream io.Writer
}

type IpRanges struct {
	SyncToken  string   `json:"syncToken"`
	CreateDate string   `json:"createDate"`
	Prefixes   []Prefix `json:"prefixes"`
}

type Prefix struct {
	IPPrefix           string `json:"ip_prefix"`
	Region             string `json:"region"`
	Service            string `json:"service"`
}

// Run invokes the CLI with the given arguments.
func (cli *CLI) Run(args []string) int {
	var ipstr string
	if len(os.Args) > 1 {
		ipstr = os.Args[1]
	} else {
		return ExitCodeError
	}

	ip := net.ParseIP(ipstr)

	res, err := http.Get(url)
	if err != nil {
		fmt.Println(err)
		return ExitCodeError
	}
	defer res.Body.Close()

	found := false
	var ranges IpRanges
	decoder := json.NewDecoder(res.Body)
	decoder.Decode(&ranges)

	for _, v := range ranges.Prefixes {
		_, ipnet, err := net.ParseCIDR(v.IPPrefix)
		if err != nil {
			fmt.Println(err)
			return ExitCodeError
		}

		if ipnet.Contains(ip) {
			found = true

			j, err := json.MarshalIndent(v, "", "  ")
			if err != nil {
				fmt.Println(err)
				return ExitCodeError
			}

			fmt.Println(string(j))
		}
	}

	if !found {
		fmt.Println("not found")
		return ExitCodeError
	}

	return ExitCodeOK
}
