%% 操作规范 %%
在本目录下执行：chaos foobar , 将会在目录chapters中建立章节foobar, 同时在main/*.tex 中自动引用该章节
若不在本目录下执行：chaos foobar, 将建立书籍 foobar
% 模板名称：vim-latex-elegantbook
% 可用选项:
% 语言环境：lang=cn,en
% 主题颜色：color=green,cyan,blue,gray,black
% 页面设置：device=pad,normal (A4纸)
% 标题风格：titlestyle=hang,display
% 章节编号：scheme=chinese 默认为阿拉伯数字
% 参考文献：bibend=biber,bibtex
% 目录选项：toc=onecol,twocol
% 旁注选项：margingpar=margintrue
% 数学字体：math=cm,newtx,mtpro2
% 定理模式：mode=simple,fancy
%%% 内置命令 %%%%
% \lstinline{foo}：用于强调提示
%%%% 内置环境 %%%%
% 定理类环境：definition, theorem,lemma,corollary, proposition
% 示例类环境：example,problem,exercise
% 提示类环境：note
% 结论类环境：conclusion,assumption,property,remark,solution
%%%% 默认图片 %%%%
% \cover{~/图片/ElegantPicture/00.jpg} 
%       以数字编号00到09,格式均为jpg, 源自https://pixabay.com/photos/
% \logo{~/图片/ElegantPicture/logo.png} 
%       目前有：logo.png,bnu.jpg,dzu.eps
