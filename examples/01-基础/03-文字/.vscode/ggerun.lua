-- @Author       : GGELUA
-- @Date         : 2022-01-17 02:57:37
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-04-28 05:53:46

print('ggerun', arg[1])
复制文件('assets/simsun.ttc', './assets/simsun.ttc')
if arg[1] == 'android' then
    编译目录('ggelua')
    编译目录('./lua')
    -- for path,rel in 遍历目录('./data') do
    --     local hash = gge.hash(path:sub(#rel+6))
    --     if 复制文件(path, string.format('./assets/%08x', hash), false) then
    --         print(string.format('assets/%08x', hash), path)
    --     end
    -- end
    写出脚本('./assets/ggelua')
else
end
