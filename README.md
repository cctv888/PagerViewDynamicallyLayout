# PagerViewDynamicallyLayout
对 FSPagerView 项目的一个改进Demo<br>
1、支持滚动大图<br>
2、支持多图水平滚动展示(对愿项目 FSPagerView 进行了调整)<br>
3、存代码创建，自动布局约束，加入了 Cartography 项目<br>
4、加入网络图片下载，加入了 Kingfisher 项目<br>

An improved Demo for the FSPagerView project
1. Support scrolling big picture
2. Support multi-picture horizontal scrolling display (adjusted FSPagerView for the wish item)
3. Save code creation, automatic layout constraints, joined Cartography project
4. Join the network picture download and join the Kingfisher project

<h3>Create Banner View</h3>
<pre>
let pv = BannerView(frame: CGRect(x: 0, y: 10, width: mWidht, height: 150))
pv.setDataSource(dataSource: BannerData())
pv.setPageControl()
self.view.addSubview(pv)
</pre>

<h3>Create Scroll horizontally View</h3>
<pre>
let sv1 = HScrollView(frame: CGRect(x: 0, y: 10, width: mWidht, height: 160))
sv1.setDataSource(dataSource: BannerData())
self.view.addSubview(sv1)
</pre>

<h3>Automatic layout constraints by Cartography</h3>
<pre>
constrain(pv, sv1) { (pv, sv1) in
  sv1.width == mWidht
  sv1.height == 160
  sv1.top >= pv.bottom + 10
}
</pre>
