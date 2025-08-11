%% 操作规范 %%
在本目录下执行：chaos foobar , 将会在目录chapters中建立章节foobar, 同时在main/*.tex 中自动引用该章节
若不在本目录下执行：chaos foobar, 将建立书籍 foobar
%% 宏包选项 %%
字体设置：fontset=adobe,fandol,founder,mac,macnew,macold,ubuntu,windows,none
字号设置：zihao= -4,5,false
排版方案：scheme=chinese,plain
标点格式：punct=quanjiao,banjiao,kaiming,CCT,plain
空格处理：space=true,false,auto
行距倍数：linespread= <数值>
段首缩进：autoindent=true,false,数值，带单位的数值
汉字间距：linestretch=数值或长度
中文字库：zhmap=true,false,zhmCJK 只在（pdf)LATEX编译时有意义
日期汉化：today=small,big,old
页眉显示：headings=true
%% 内置字体 %%%%
通用：\songti,\heiti,\kaishu,\fangsong
windows,founder,macnew : \lishu,\youyuan
windows：\yahei
macnew： \pingfang
Ubuntu：不含\fangsong
