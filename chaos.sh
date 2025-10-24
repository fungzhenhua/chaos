#! /bin/sh
#
# Program  : chaos.sh
# Author   : fengzhenhua
# Email    : fengzhenhua@outlook.com
# Date     : 2025-10-24 11:19
# CopyRight: Copyright (C) 2022-2030 Zhen-Hua Feng(冯振华)
# License  : Distributed under terms of the MIT license.
# 功能：一键创建结构化 LaTeX 项目，智能管理章节与资源
#
# 注解：本程序之所以用chaos命名，因为在研究生毕业时，某博士导师当众纠正我的发音“Kei-阿丝”为"超丝“，这个纠正是极其错误的，为纪念这一事件，程序命名为chaos.
#
# 调入私有函数库
SHARE_FUNS=( Share_Fun_Menu.sh Share_Fun_KeySudo.sh Share_Fun_Install.sh Share_Fun_Weather.sh )
SHARE_PWD="$HOME/.Share_Fun"
SHARE_LOSS=0
for SHARE_FUN in ${SHARE_FUNS[@]}; do
    if [[ ! -e "$SHARE_PWD/$SHARE_FUN" ]]; then
        SHARE_LOSS=1
    fi
done
if [[ $SHARE_LOSS == 1 ]]; then
    if [[ -e  $SHARE_PWD ]]; then
        rm -rf  $SHARE_PWD
    fi
    git clone git@fung:fungzhenhua/Share_Fun $SHARE_PWD
fi
for SHARE_FUN in ${SHARE_FUNS[@]}; do
    source "$SHARE_PWD/$SHARE_FUN"
done
# 保存脚本变量
CH_ARGS=( "$0" "$@" )
# 变量配置
CH_VERSION="${CH_ARGS[0]##*/}-V1.6"
CH_SOURCE="$HOME/.chaos"
CH_CFG="$CH_SOURCE/info.sh"
CH_PATH="$PWD"
# 建立模板源
if [[ ! ${CH_ARGS[0]} == ${CH_ARGS[0]%.sh} ]]; then
    if [ ! -e $CH_SOURCE ]; then
        cp -r ./CH-TEMP $CH_SOURCE
    else
        echo -n "${CH_SOURCE}已经存在，是否覆盖安装？y/n : "; read CH_YN
        if [[ $CH_YN == "y" || $CH_YN == "Y" ]]; then
            rm -rf $CH_SOURCE
            cp -r ./CH-TEMP $CH_SOURCE
        fi
    fi
fi
# 检测是否已经安装
SFI_INSTALL ${CH_ARGS[1]} ${CH_ARGS[0]} $CH_VERSION
if [ ! -e $CH_CFG ]; then
   touch $CH_CFG
   chmod +w $CH_CFG
   echo "#! /bin/sh"               > $CH_CFG
   echo "CH_AUTHOR_ZH=\" \""      >> $CH_CFG
   echo "CH_AUTHOR_EN=\" \""      >> $CH_CFG
   echo "CH_EMAIL=\" \""          >> $CH_CFG
   echo "CH_OCID=\" \""           >> $CH_CFG
   echo "CH_CITY_ZH=\" \""        >> $CH_CFG
   echo "CH_CITY_EN=\" \""        >> $CH_CFG
   echo "CH_POSTCODE=\" \""       >> $CH_CFG
   echo "CH_SCHOOL_ZH=\" \""      >> $CH_CFG
   echo "CH_SCHOOL_EN=\" \""      >> $CH_CFG
   echo "CH_INSTITUTE_ZH=\" \""   >> $CH_CFG
   echo "CH_INSTITUTE_EN=\" \""   >> $CH_CFG
   echo "CH_AFFILIATION_EN=\" \"" >> $CH_CFG
else
    source $CH_CFG
fi
CH_DATE_EN=$(date +"%Y-%m-%d")
CH_DATE_ZH=$(date +"%Y年%m月%d日")
# 读取模板
CH_FILES=($(ls $CH_SOURCE))
# 替换关键字
CH_ADD_INFO(){
    sed -i "s/<+title+>/${CH_ARGS[1]}/" "$2"
    if [[ $1 == "zh" ]]; then
        sed -i "s/<+author+>/$CH_AUTHOR_ZH/" "$2"
        sed -i "s/<+date+>/$CH_DATE_ZH/" "$2"
        sed -i "s/<+city+>/$CH_CITY_ZH/" "$2"
        sed -i "s/<+institute+>/$CH_INSTITUTE_ZH/" "$2"
    else
        sed -i "s/<+author+>/$CH_AUTHOR_EN/" "$2"
        sed -i "s/<+date+>/$CH_DATE_EN/" "$2"
        sed -i "s/<+city+>/$CH_CITY_EN/" "$2"
        sed -i "s/<+institute+>/$CH_INSTITUTE_EN/" "$2"
        sed -i "s/<+affiliation+>/$CH_AFFILIATION_EN/" "$2"
    fi
    sed -i "s/<+email+>/$CH_EMAIL/" "$2"
    sed -i "s/<+orcid+>/$CH_ORCID/" "$2"
    sed -i "s/<+postcode+>/$CH_POSTCODE/" "$2"
    clear
    echo "${2%/*} 创建成功! "
}
CH_CURRENT=$(ls ${CH_PATH})
if [[ ${CH_CURRENT[@]} =~ "main" || ${CH_CURRENT[@]} =~ "chapters" ]]; then
    CH_CHAPATH="${CH_PATH}/chapters/${CH_ARGS[1]}"
    if [[ ! -e  ${CH_CHAPATH} ]]; then
        mkdir -p "${CH_CHAPATH}"
        touch "${CH_CHAPATH}/${CH_ARGS[1]}.tex"
        CH_CHAMAIN=$(ls ${CH_PATH}/main/*.tex)
        echo "\documentclass[../../main/${CH_CHAMAIN#*main/}]{subfiles}" \
            > "${CH_CHAPATH}/${CH_ARGS[1]}.tex"
        echo "\begin{document}" \
            >> "${CH_CHAPATH}/${CH_ARGS[1]}.tex"
        echo "<++>" \
            >> "${CH_CHAPATH}/${CH_ARGS[1]}.tex"
        echo "\end{document}" \
            >> "${CH_CHAPATH}/${CH_ARGS[1]}.tex"
        sed -i "/\%----chapters----/a \\\\\subfile{..\/chapters\/${CH_ARGS[1]}\/${CH_ARGS[1]}.tex}" ./main/${CH_CHAMAIN#*main/}
    else
        echo "目录${CH_ARGS[1]}已经存在, 请重新命名！！"
        exit
    fi
else
    # 列出模板
    NEO_LIST "${CH_FILES[*]}" 1
    # 建立文件目录
    if [[ ! -e ${CH_ARGS[1]} ]]; then
        cp -r "$CH_SOURCE/$EDFILE" "${CH_PATH}/${CH_ARGS[1]}"
        cp "$CH_SOURCE/pkgset.tex" "${CH_PATH}/${CH_ARGS[1]}/pkgset.tex"
    else
        echo "目录${CH_ARGS[1]}已经存在, 请重新命名！！"
        exit
    fi
    # 分类处理文档
    case ${EDFILE} in
        "article")
            CH_TARGET="${CH_PATH}/${CH_ARGS[1]}/${CH_ARGS[1]}.tex"
            mv "${CH_PATH}/${CH_ARGS[1]}/article.tex" "${CH_TARGET}"
            CH_ADD_INFO "en" "${CH_TARGET}"
            ;;
        "ctexart")
            CH_TARGET="${CH_PATH}/${CH_ARGS[1]}/${CH_ARGS[1]}.tex"
            mv "${CH_PATH}/${CH_ARGS[1]}/article.tex" "${CH_TARGET}"
            CH_ADD_INFO "zh" "${CH_TARGET}"
            ;;
        "ctexbeamer")
            CH_TARGET="${CH_PATH}/${CH_ARGS[1]}/${CH_ARGS[1]}.tex"
            mv "${CH_PATH}/${CH_ARGS[1]}/beamer.tex" "${CH_TARGET}"
            CH_ADD_INFO "zh" "${CH_TARGET}"
            ;;
        "ctexbook")
            CH_TARGET="${CH_PATH}/${CH_ARGS[1]}/main/${CH_ARGS[1]}.tex"
            mv "${CH_PATH}/${CH_ARGS[1]}/main/book.tex" "${CH_TARGET}"
            CH_ADD_INFO "zh" "${CH_TARGET}"
            ;;
        *)
            clear
            rm -rf "${CH_PATH}/${CH_ARGS[1]}"
            echo "尚未完成${EDFILE}模板建设，敬请期待！"
            ;;
    esac
fi
