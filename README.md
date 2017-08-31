# tableViewBarView
利用tableView旋转横向滚动的柱状图，可复用，一年两年的长度无压力~


![image](https://github.com/shuaishuaihenan/tableViewBarView/blob/master/tableView%E6%A8%AA%E5%90%91%E7%BF%BB%E8%BD%AC%E6%9F%B1%E7%8A%B6%E5%9B%BE%E5%A4%8D%E7%94%A81.gif)


把cell替换成YXRunStaticBarTableViewCell
初始化tableView的时候 设定frame之前 逆向旋转90度
在tableView代理中cell顺时针旋转90度
