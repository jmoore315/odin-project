
def print_dir_recursive(dir)
	Dir.foreach(dir) do |entry|
		puts entry
		print_dir_recursive(entry) if File.directory?(entry) && (ObjectSpace.count_objects()[:T_FILE] < )
	end
end

Dir.chdir('/')
print_dir_recursive(Dir.pwd)