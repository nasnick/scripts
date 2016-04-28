
wp_content = []
wp_includes = []
wp_admin = []

a = File.open('/Users/nickschofield/Desktop/wordpress/wp-content') do |a|
  a.each_line do |line_a|
    wp_content << line_a
 end
end

b = File.open('/Users/nickschofield/Desktop/wordpress/wp-includes') do |b|
  b.each_line do |line_b|
    wp_includes << line_b
 end
end



c = File.open('/Users/nickschofield/Desktop/wordpress/wp-admin') do |c|
  c.each_line do |line_c|
    wp_admin << line_c
 end
end

all_sites = []
d = File.open('/Users/nickschofield/Desktop/wordpress/all_sites') do |d|
  d.each_line do |line_d|
    all_sites << line_d
 end
end

array = []

for i in all_sites
	if wp_content.include?(i)
		if wp_includes.include?(i)
			if wp_admin.include?(i)
				array << i
			end
		end
	end
end
File.open("/Users/nickschofield/Desktop/wordpress/unique", "w+") do |f|
  array.each { |element| f.puts(element) }
end