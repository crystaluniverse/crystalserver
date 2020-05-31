AnsiColors = {
        "BLACK" => "\u001b[30m",
        "RED"  => "\u001b[31m",
        "GREEN" => "\u001b[32m",
        "YELLOW" => "\u001b[33m",
        "BLUE" => "\u001b[34m",
        "MAGENTA" => "\u001b[35m",
        "CYAN" => "\u001b[36m",
        "WHITE" => "\u001b[37m",
        "RESET" => "\u001b[0m",
}

class Crystal::MD::Parser < IO::Memory
      def process(start : Int32)
        data_blocks = [] of String
        buffer = IO::Memory.new
        data_block_started = false
        seek(start)
        each_line do |line|
            str = line.to_unsafe 
            lineslice = line.byte_slice(0, 7).to_s

            if lineslice == "```toml" || lineslice == "```yaml" || lineslice == "```json"
                data_block_started = true 
            elsif str[0].unsafe_chr == '`' && str[1].unsafe_chr == '`' && str[2].unsafe_chr == '`' && data_block_started
                data_block_started = false 
                data_blocks.push(buffer.to_s)
                buffer = IO::Memory.new
            elsif data_block_started
                buffer << line
            else
                self.line_process(line.strip)
            end
        end
        data_blocks.each do |block|
            code_block_process block
        end
    end
    

    def line_process(line : String)
        bytesize = line.bytesize

            return unless bytesize > 0

            pos = 0
            str = line.to_unsafe        
            
            tags_found = false
            tags_start = 0
            tags_end = 0

            job_found = false
            job_start = 0
            job_end = 0

            data_block_found = false
            data_block_start = 0
            data_block_end = 0

            remark_found = false

            buffer = IO::Memory.new
            remark_buffer = IO::Memory.new

            # Logs
            while pos < bytesize && str[pos].unsafe_chr.ascii_number?
                pos += 1
            end
            
            log_level = str[pos].unsafe_chr == "|" ? line.byte_slice(0, pos).to_u8 : 3_u8

            while pos < bytesize
                first = str[pos].unsafe_chr
                second = str[pos+1].unsafe_chr
                third = str[pos+2].unsafe_chr
                
                if str[pos].unsafe_chr == '`'
                    pos += 1
                elsif first == '<' &&  second == '<'
                    remark_found = false
                    pos += 2
                    tags_start = pos
                elsif first == '>' && second == '>'
                    remark_found = false
                    tags_end = pos - 1
                    tags_found = true
                    pos += 1
                elsif first == '[' &&  second == '$'
                    remark_found = false
                    pos += 2
                    job_start = pos -1
                elsif first == ']' && job_start > 0
                    remark_found = false
                    job_end = pos
                    job_found = true
                    pos += 1
                elsif first == ' ' && second == '#' && pos != 0
                    #comment can be at beginning of line TODO:
                    remark_found = true
                    pos += 1
                else
                    if remark_found
                        remark_buffer << str[pos].unsafe_chr
                    else
                        buffer << remark_buffer
                        buffer << str[pos].unsafe_chr
                    end
                    pos += 1
                end
            end
            
            tags = line.byte_slice(tags_start, tags_end-tags_start).to_s
            job = line.byte_slice(job_start, job_end-job_start).to_s
            log_level = log_level.to_s
            text = buffer.to_s
    end

    def code_block_process(block : String)
        puts block
    end
end