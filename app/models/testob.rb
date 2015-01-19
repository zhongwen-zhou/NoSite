module Testob
fnames = ['赵', '钱', '孙', '李', '王', '张', '谢']
names = ['大鹏', '二虎', '国庆', '党庆']
genders = ['男', '女']
departments = ['人力资源部', '财务部', '服务部', '信息技术部']
jobs = ['薪酬专员', '人力资源专员', '培训专员', '会计', '出纳', '税务专员', '空服', '项目经理']
households = ['四川', '贵州', '江苏', '上海', '北京', '黑龙江', '重庆']
nationals = ['汉族', '彝族', '羌族', '朝鲜族', '傣族']
educations = ['高中', '专科', '高职', '本科', '硕士', '博士']
politicals = ['群众', '团员', '党员', '其他党派人士']

es = []

class Employee
	attr_accessor :id, :name, :gender, :age, :department, :job, :entry_time, :household, :height, :national, :education, :tel, :political

end

2000.times do |index|
	e = Employee.new
	e.id = index + 1
	e.name = "#{fnames[index%fnames.size]}#{names[index%names.size]}"
	e.gender = "#{genders[index%genders.size]}"
	e.age = 20 + index%9
	e.department = "#{departments[index%departments.size]}"
	e.job = "#{jobs[index%jobs.size]}"
	e.entry_time = Time.now - (index%9).month
	e.household = "#{households[index%households.size]}"
	e.height = 180 + index%9
	e.national = "#{nationals[index%nationals.size]}"
	e.education = "#{educations[index%educations.size]}"
	e.tel = "139#{index%9}34#{index%7}28#{index%8}#{index%3}"
	e.political = "#{politicals[index%politicals.size]}"
	es.push e
end

File.open("/Users/zhouzhongwen/tmp/test.json", "a:utf-8") do |file|
	file.puts es.to_json
end
end