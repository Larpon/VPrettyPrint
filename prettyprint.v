module main

const double_quote = 1
const single_quote = 2

const msg = '{"id": "benny boy", "names": ["foo", "b\\"ar"]}'

fn main() {
	pprint(msg)
}

[params]
struct PrettyPrinterConfig {
pub mut:
	indent int = 2
}

struct PrettyPrinter {
pub mut:
	indent int = 2
}

pub fn pprint(text string) {
	pp := PrettyPrinter{
		indent: 1
	}

	println(pprint_build_string(text, pp))
}

pub fn pprint_with_config(text string, pprinter PrettyPrinterConfig) {
	pp := PrettyPrinter{
		indent: pprinter.indent
	}
	
	println(pprint_build_string(text, pp))
}

pub fn pprint_build_string(text string, pp PrettyPrinter) string {
	mut indent := 0
	mut output := ""  
	
	mut squote := false
	mut dquote := false
	mut in_string := false
	
	mut prev := ` `
	
	for c in text {
		// Check if we're in a string
		if c == '"'[0] {
			if prev != '\\'[0] {
				dquote = !dquote
			}
		} else if c == "'"[0] {
			if prev != '\\'[0] {
				squote = !squote
			}
		}
		
		in_string = squote || dquote
		
		if (c == `[` || c == `{`) && !in_string{
			indent += 1 * pp.indent
			output += "${c.ascii_str()}\n${' '.repeat(indent)}"	
		} else if (c == `]` || c == `}`) && !in_string {
			indent -= 1 * pp.indent
			if indent < 0 { indent = 0 }
			output += "\n${' '.repeat(indent)}${c.ascii_str()}"	
		} else if c == `,` {
			output += ",\n${' '.repeat(indent)}"	
		} else if c == `:` && !in_string {
			output += ": "
		} else if c == ` ` && !in_string {
		} else {
			output += c.ascii_str()
		}
		
		prev = c
	}
	
	return output
}
