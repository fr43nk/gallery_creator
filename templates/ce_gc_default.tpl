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
				<div class="image_container" onmouseover="<?php echo  $Album["thumbMouseover"]; ?>">
<?php if ($Album["href"]): ?>
					<a href="<?php echo $Album["href"]; ?>" title="<?php echo $Album["title"]; ?>">
<?php endif; ?>
						<img src="<?php echo $Album["thumb_src"]; ?>" alt="<?php echo $Album["alt"]; ?>" class="<?php echo $Album["class"]; ?>" />
<?php if ($Album["href"]): ?>
					</a>
<?php endif; ?>
				</div>
			</div>
			<div class="col_2">
				<h2><?php echo $Album["name"]; ?></h2>
<?php if ($Album["count"]): ?>				
				<p class="count_pics"><?php echo $Album["count"]; ?> <?php echo $GLOBALS['TL_LANG']['gallery_creator']['pictures']; ?></p>
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
<!--start detailview-->
<div class="<?php echo $this->class; ?> gallery_creator block"<?php echo $this->cssID; ?><?php if ($this->style): ?> style="<?php echo $this->style; ?>"<?php endif; ?>>

<?php if ($this->headline): ?>
<<?php echo $this->hl; ?>><?php echo $this->headline; ?></<?php echo $this->hl; ?>>
<?php endif; ?>

<?php if ($this->backLink): ?>
<div class="backLink"><a href="<?php echo $this->backLink; ?>" title="zurück">« <?php echo $GLOBALS['TL_LANG']['gallery_creator']['back_to_general_view']; ?></a></div>
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
						<img src="<?php echo $Subalbum["thumb_src"]; ?>" alt="<?php echo $Subalbum["alt"]; ?>" class="<?php echo $Subalbum["class"]; ?>" />
<?php if ($Subalbum["href"]): ?>
					</a>
<?php endif; ?>
				</div>
			</div>
			<div class="col_2">
				<h2><?php echo $Subalbum["name"]; ?></h2>
<?php if ($Subalbum["count"]): ?>				
				<p class="count_pics"><?php echo $Subalbum["count"]; ?> <?php echo $GLOBALS['TL_LANG']['gallery_creator']['pictures']; ?></p>
<?php endif; ?>
<?php if ($Subalbum["count_subalbums"]): ?>				
				<p class="count_pics"><?php echo $Subalbum["count_subalbums"]; ?> <?php echo $GLOBALS['TL_LANG']['gallery_creator']['subalbums']; ?></p>
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

<?php if ($this->albumComment): ?>
<div class="albumComment">
	<p>
<?php echo $this->albumComment; ?>
	</p>
</div>
<?php endif; ?>

<?php echo $this->pagination; ?>
<?php $col=0; ?>
<?php $row=0; ?>
<?php $imageNumber=0; ?>
<?php if ($this->arrPictures): ?>
<ul class="album_preview">
<?php foreach ($this->arrPictures as $Picture): ?>
<?php $imageNumber++; ?> 
<?php $col++; ?>
<?php if ($col==1): ?>
<?php $row++; ?>
	<li class="level_1 block <?php echo ($row%2==0 ? "odd" : "even"); ?>">
		<ul class="level_2 block"> 
<?php endif; ?>
			<li class="level_2 inline <?php echo ($col==1 ? " first_col" : "") . ($col==$this->colsPerRow ? " last_col" : ""); ?>">
			<div class="image_container" style="float:left; <?php echo $this->imagemargin; ?>">
<?php if ($Picture["href"]): ?>
				<a href="<?php echo $Picture["href"]; ?>" <?php echo $Picture["lightbox"]; ?> title="<?php echo $Picture["comment"]; ?>">
<?php endif; ?>
				<img src="<?php echo $Picture["thumb_src"]; ?>" class="<?php echo $Picture["class"]; ?>" alt="<?php echo $Picture["title"] ? $Picture["title"] : $Picture["name"]; ?>" />
<?php if ($Picture["href"]!=""): ?>
				</a>
<?php endif; ?>
			
			</div>				
			</li>	
<?php if ($col==$this->colsPerRow OR count($this->arrPictures)==$imageNumber && $this->colsPerRow!=0): ?> 
<?php $col=0; ?>
		</ul>
	</li>
<!--  end row  -->
<?php endif;?>
<?php endforeach;?>
</ul>
<?php endif;?>
</div>
<!--end detailview-->

<?php endif; ?>


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
	$$(".gallery_creator ul.list_albums").getFirst("li").addClass('active');
	//Klassenzuweisung 
	$$(".gallery_creator ul.list_albums li.level_1").addEvent('mouseover', function() {
		$$(".gallery_creator ul.list_albums").getFirst("li").removeClass('active');
		this.addClass('active');
	});
	//Klassenentfernung 
	$$(".gallery_creator ul.list_albums li.level_1").addEvent('mouseout', function() {
		this.removeClass('active');
	});

});
//--><!]]>
</script>

<!-- indexer::stop -->