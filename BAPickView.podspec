Pod::Spec.new do |s|
    s.name         = "BAPickView"
    s.version      = "1.1.0"
    s.summary      = '目前为止，最为精简的 自定义 pickView 和 日期选择器 封装！'
    s.homepage     = 'https://github.com/BAHome/BAPickView'
    s.license      = 'MIT'
    s.authors      = { 'boa' => 'sunboyan@outlook.com' }
    s.platform     = :ios, '7.0'
    s.source       = { :git => 'https://github.com/BAHome/BAPickView.git', :tag => s.version.to_s }
    s.source_files = 'BAPickView/BAPickView/*.{h,m}'
    s.requires_arc = true
    s.resource     = 'BAPickView/**/*.bundle'

end
