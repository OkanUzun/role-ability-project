<?php include "header.php"; ?>

  <div class="wrapper">
    <?php include "sidebar.php"; ?>
    <div class="page-content">
      <?php include "navbar.php"; ?>
      <div class="container-fluid">
        <div class="card">
          <div class="card-header">
            <div class="card-title">
              <div class="name">Bilişim Departmanı<div class="manager"><strong>Departman Müdürü:</strong> Deniz Güzel</div></div>
              <div class="date">
                <span><strong>Oluşturulma Tarihi:</strong> 21/11/2016</span>
                <span><strong>Düzenleme Tarihi:</strong> 22/11/2016</span>
              </div>
            </div>
          </div>
          <div class="card-block">
            <table class="table">
              <thead>
              <tr>
                <th>Kayıtlı Birimler</th>
                <th>Çalışan Sayısı</th>
                <th>Detay</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <td>Ağ Birimi</td>
                <td>2</td>
                <td class="text-xs-center"><a href="unit-detail.php" class="table-icon" rel="tooltip" title="Detay"><i class="mdi mdi-magnify"></i></a></td>
              </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>

<?php include "footer.php"; ?>