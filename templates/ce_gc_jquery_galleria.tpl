<!-- indexer::continue -->
<?php $GLOBALS['TL_JAVASCRIPT'][] = 'system/modules/gallery_creator/html/gallery_creator_fe.js'; ?>

<?php if (!$this->Input->get('vars')): ?>
<!--start album-overview-->
<div class="<?php echo $this->class; ?> gallery_creator block"<?php echo $this->cssID; ?><?php if ($this->style): ?> style="<?php echo $this->style; ?>"<?php endif; ?>>
<?php if ($this->headline): ?>
<<?php echo $this->hl; ?>><?php echo $this->headline; ?></<?php echo $this->hl; ?>>
<?php endif; ?>
	
<?php echo $this->pagination; ?>
<?php if (count($this->arrAlbums)>0): ?>
<ul class="list_albums">
<?php foreach ($this->arrAlbums as $Album): ?> 
	<li class="level_1 block row"  style="<?php echo $this->imagemargin; ?>">
		<div class="tstamp block">[<?php echo $Album["event_date"]; ?>]</div>
			<div class="col_1">
				<div class="image_container"  onmouseover="<?php echo  $Album["thumbMouseover"]; ?>">
<?php if ($Album["href"]): ?>
					<a href="<?php echo $Album["href"]; ?>" title="<?php echo $Album["title"]; ?>">
<?php endif; ?>
						<img src="<?php echo $Album["thumb_src"]; ?>" alt="<?php echo $Album["alt"]; ?>" class="<?php echo $Album["class"]; ?>">
<?php if ($Album["href"]): ?>
					</a>
<?php endif; ?>
				</div>
			</div>
			<div class="col_2">
				<h2><?php echo $Album["name"]; ?></h2>
<?php if ($Album["count"]): ?>				
				<p class="count_pics"><?php echo $Album["count"]; ?> <?php echo $GLOBALS["TL_LANG"]["gallery_creator"]["pictures"]; ?></p>
<?php endif; ?>
<?php if ($Album["count_subalbums"]): ?>				
				<p class="count_pics"><?php echo $Album["count_subalbums"]; ?> <?php echo $GLOBALS['TL_LANG']['gallery_creator']['subalbums']; ?></p>
<?php endif; ?>		
<?php if ($Album["comment"]): ?>
				<p class="album_comment"><?php echo $Album["comment"]; ?></p>
<?php endif; ?>
			</div>
		<div class="clr"><!--clearing-box--></div>
	</li>
<?php endforeach; ?>
</ul>
<?php endif; ?>	
</div>
<!--end album-overview-->
<?php endif; ?>






<?php 
if ($this->Input->get('vars')): ?>
<div class="<?php echo $this->class; ?> gallery_creator block"<?php echo $this->cssID; ?><?php if ($this->style): ?> style="<?php echo $this->style; ?>"<?php endif; ?>>

<?php
/*import jquery and galeria.js*/
$GLOBALS['TL_HEAD'][] = '<!-- load jquery for the Galleria-script -->';
$GLOBALS['TL_HEAD'][] = '<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.js"></script>';
$GLOBALS['TL_HEAD'][] = '<!-- load Galleria -->';
$GLOBALS['TL_HEAD'][] = '<script type="text/javascript" src="system/modules/gallery_creator/js/galleria/galleria.js"></script>';
?>
<!--start detailview-->
<?php if ($this->headline): ?>
<<?php echo $this->hl; ?>><?php echo $this->headline; ?></<?php echo $this->hl; ?>>
<?php endif; ?>

<?php if ($this->backLink): ?>
<div class="backLink"><a href="<?php echo $this->backLink; ?>" title="zur&uuml;ck">« <?php echo $GLOBALS['TL_LANG']['gallery_creator']['back_to_general_view']; ?></a></div>
<?php endif; ?>

<?php if ($this->Albumname): ?>
<h2><?php echo $this->Albumname; ?></h2>
<?php endif; ?>

<?php if ($this->error): ?>
<?php foreach ($this->error as $errorMessage): ?>
<p><?php echo $errorMessage; ?></p>
<?php endforeach; ?>
<?php return; ?>
<?php endif; ?>

<?php echo $this->pagination; ?>
<?php if ($this->subalbums): ?>
<!-- Unteralben anzeigen -->
<div class="subalbums">
	<h3>Unteralben von: <?php echo $this->Albumname; ?></h3>
	<ul class="list_albums">
<?php foreach ($this->subalbums as $Subalbum): ?>
		<li class="level_1 block row"  style="<?php echo $this->imagemargin; ?>">
		<div class="tstamp block">[<?php echo $Subalbum["event_date"]; ?>]</div>
			<div class="col_1">
				<div class="image_container" onmouseover="<?php echo  $Album["thumbMouseover"]; ?>">
<?php if ($Subalbum["href"]): ?>
					<a href="<?php echo $Subalbum["href"]; ?>" title="<?php echo $Subalbum["title"]; ?>">
<?php endif; ?>
						<img src="<?php echo $Subalbum["thumb_src"]; ?>" alt="<?php echo $Subalbum["alt"]; ?>" class="<?php echo $Subalbum["class"]; ?>">
<?php if ($Subalbum["href"]): ?>
					</a>
<?php endif; ?>
				</div>
			</div>
			<div class="col_2">
				<h2><?php echo $Subalbum["name"]; ?></h2>
<?php if ($Subalbum["count"]): ?>				
				<p class="count_pics"><?php echo $Subalbum["count"]; ?> <?php echo $GLOBALS["TL_LANG"]["gallery_creator"]["pictures"]; ?></p>
<?php endif; ?>
<?php if ($Subalbum["count_subalbums"]): ?>				
				<p class="count_pics"><?php echo $Subalbum["count_subalbums"]; ?> <?php echo $GLOBALS["TL_LANG"]["gallery_creator"]["subalbums"]; ?></p>
<?php endif; ?>				
<?php if ($Subalbum["comment"]): ?>
				<p class="album_comment"><?php echo $Subalbum["comment"]; ?></p>
<?php endif; ?>
			</div>
		<div class="clr"><!--clearing-box--></div>
	</li>
<?php endforeach;?>
	</ul>
</div>
<!-- Ende Unteralben anzeigen -->
<?php endif; ?>


<?php if ($this->arrPictures): ?>
<div id="galleria" class="<?php echo $this->class; ?> gallery_creator block"<?php echo $this->cssID; ?><?php if ($this->style): ?> style="<?php echo $this->style; ?>"<?php endif; ?>>
<?php foreach ($this->arrPictures as $Picture): ?>
<a href="<?php echo $Picture["href"]; ?>" rel="" title="<?php echo $Picture["comment"]; ?>">
	<img src="<?php echo $Picture["thumb_src"]; ?>" class="<?php echo $Picture["class"]; ?>" alt="<?php echo $Picture["title"] ? $Picture["title"] : $Picture["comment"]; ?>">
</a>
<?php endforeach;?>
</div>
<?php endif; ?>
</div>
<!--end detailview-->




<script type="text/javascript">
<!--//--><![CDATA[//><!--
	/*-- Load the classic theme: */
	Galleria.loadTheme('system/modules/gallery_creator/js/galleria/themes/classic/galleria.classic.js');
	
	/* initialize Galleria */
	$("#galleria").galleria({
		//width: 500,
		//This CSS-rule is read by Galleria to define the gallery height
		height: 500,
		//debug:true,
		autoplay:5000,
		transitionSpeed:1500,
		showInfo:true,
		showImagenav:true,
		//choose between: fade, flash, pulse, slide, fadeslide
		transition:'flash',
		imageMargin:20
	});
//--><!]]>
</script>
<?php endif; ?>

<!-- javascript, das sowieso geladen wird -->
<script type="text/javascript">
<!--//--><![CDATA[//><!--
	window.addEvent('domready', function() {
   	//Weiterleitung bei Klick auf das, das Bild enthaltende Listenelement
	$$("ul.list_albums li.level_1").addEvent('click', function() {
		var href = this.getElement('a').get('href');
		var myURI = new URI();
		var redirect = myURI.get('scheme') + '://' + myURI.get('host') + myURI.get('directory') + href;
		window.parent.location=redirect;
	});
	/**
	 * Cursor über h2
	 */
	$$('.gallery_creator li.level_1').setStyle('cursor', 'pointer');
	
	//bei domready erhält das erste Listenelement einen overlay
	$$("ul.list_albums").getFirst("li").addClass('active');
	//Klassenzuweisung 
	$$("ul.list_albums li.level_1").addEvent('mouseover', function() {
		$$("ul.list_albums").getFirst("li").removeClass('active');
		this.addClass('active');
	});
	//Klassenentfernung 
	$$("ul.list_albums li.level_1").addEvent('mouseout', function() {
		this.removeClass('active');
	});
});
//--><!]]>
</script>


<!-- indexer::stop -->